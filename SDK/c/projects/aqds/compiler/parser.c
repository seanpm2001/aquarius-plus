#include "parser.h"
#include "tokenizer.h"
#include "expr.h"
#include "symbols.h"
#include <stdarg.h>

static uint16_t lbl_idx;
static uint16_t flags;
static uint8_t  arg_count;

// Flags to indicate which helper functions to generate
#define FLAGS_USES_MULTSI (1 << 0)
#define FLAGS_USES_DIVSI  (1 << 1)
#define FLAGS_USES_MODSI  (1 << 2)
#define FLAGS_USES_SHL    (1 << 3)
#define FLAGS_USES_SHR    (1 << 4)

static void emit_expr(struct expr_node *node);

static void expect_ack(uint8_t token) {
    if (get_token() != token)
        syntax_error();
    ack_token();
}

static void expect(uint8_t token) {
    if (get_token() != token)
        syntax_error();
}

static void emit(char *fmt, ...) {
    tmpbuf[0] = ' ';
    tmpbuf[1] = ' ';
    tmpbuf[2] = ' ';
    tmpbuf[3] = ' ';

    va_list ap;
    va_start(ap, fmt);
    int len = vsprintf(tmpbuf + 4, fmt, ap);
    va_end(ap);

    tmpbuf[4 + len]     = '\n';
    tmpbuf[4 + len + 1] = 0;

    output_puts(tmpbuf, 4 + len + 1);
}

static void emit_binary(struct expr_node *node) {
    emit_expr(node->left_node);
    emit("push    hl");
    emit_expr(node->right_node);
    emit("ex      de,hl");
    emit("pop     hl");
}

static void emit_local_lbl(int idx) {
    int len = sprintf(tmpbuf, ".l%d:\n", idx);
    output_puts(tmpbuf, len);
}

static void emit_lbl(const char *str) {
    int len = sprintf(tmpbuf, "_%s:\n", str);
    output_puts(tmpbuf, len);
}

static int gen_local_lbl(void) {
    return lbl_idx++;
}

static void emit_cast_boolean(void) {
    int lbl = gen_local_lbl();
    emit("ld      a,h");
    emit("or      l");
    emit("ld      hl,0");
    emit("jr      z,.l%d", lbl);
    emit("inc     l");
    emit_local_lbl(lbl);
}

static void emit_expr(struct expr_node *node) {
    switch (node->op) {
        case TOK_CONSTANT: {
            emit("ld      hl,%d", node->val);
            break;
        }

        case TOK_IDENTIFIER: {
            struct symbol *sym = node->sym;
            if (sym->type == (SYMTYPE_GLOBAL | SYMTYPE_VAR_CHAR)) {
                emit("ld      a,(_%s)", sym->name);
                emit("ld      h,0");
                emit("ld      l,a");

            } else if (sym->type == (SYMTYPE_GLOBAL | SYMTYPE_VAR_INT)) {
                emit("ld      hl,(_%s)", sym->name);

            } else {
                printf("Unimplemented identifier symbol type in expression!\n");
                syntax_error();
            }
            break;
        }

        case '=': {
            if (node->left_node->op != TOK_IDENTIFIER)
                error("Expected identifier");

            emit_expr(node->right_node);
            if (node->left_node->sym->type == (SYMTYPE_GLOBAL | SYMTYPE_VAR_CHAR)) {
                emit("ld      a,l");
                emit("ld      (_%s),a", node->left_node->sym->name);

            } else if (node->left_node->sym->type == (SYMTYPE_GLOBAL | SYMTYPE_VAR_INT)) {
                emit("ld      (_%s),hl", node->left_node->sym->name);

            } else {
                printf("Unimplemented identifier symbol type in expression!\n");
                syntax_error();
            }
            break;
        }

        case TOK_OP_NEG:
            emit_expr(node->left_node);
            emit("ex      de,hl");
            emit("ld      hl,0");
            emit("or      a");
            emit("sbc     hl,de");
            break;

        case '~':
            emit_expr(node->left_node);
            emit("ld      a,h");
            emit("xor     $FF");
            emit("ld      h,a");
            emit("ld      a,l");
            emit("xor     $FF");
            emit("ld      l,a");
            break;

        case '*':
            emit_binary(node);
            emit("call    __multsi");
            flags |= FLAGS_USES_MULTSI;
            break;

        case '/':
            emit_binary(node);
            emit("call    __divsi");
            flags |= FLAGS_USES_DIVSI;
            break;

        case '%':
            emit_binary(node);
            emit("call    __modsi");
            flags |= FLAGS_USES_MODSI;
            break;

        case '+':
            emit_binary(node);
            emit("add     hl,de");
            break;

        case '-':
            emit_binary(node);
            emit("or      a");
            emit("sbc     hl,de");
            break;

        case TOK_OP_SHL:
            emit_binary(node);
            emit("call    __shl");
            flags |= FLAGS_USES_SHL;
            break;

        case TOK_OP_SHR:
            emit_binary(node);
            emit("call    __shr");
            flags |= FLAGS_USES_SHR;
            break;

            // case TOK_OP_LE:
            // case TOK_OP_GE:
            // case '<':
            // case '>':
            // case TOK_OP_EQ:
            // case TOK_OP_NE:

        case '&':
            emit_binary(node);
            emit("ld      a,h");
            emit("and     d");
            emit("ld      h,a");
            emit("ld      a,l");
            emit("and     e");
            emit("ld      l,a");
            break;

        case '^':
            emit_binary(node);
            emit("ld      a,h");
            emit("xor     d");
            emit("ld      h,a");
            emit("ld      a,l");
            emit("xor     e");
            emit("ld      l,a");
            break;

        case '|':
            emit_binary(node);
            emit("ld      a,h");
            emit("or      d");
            emit("ld      h,a");
            emit("ld      a,l");
            emit("or      e");
            emit("ld      l,a");
            break;

        case TOK_OP_AND: {
            // Boolean-AND operation with short circuit
            int lbl1 = gen_local_lbl();
            int lbl2 = gen_local_lbl();
            emit_expr(node->left_node);
            emit("ld      a,h");
            emit("or      l");
            emit("jr      z,.l%d", lbl1);
            emit_expr(node->right_node);
            emit("ld      a,h");
            emit("or      l");
            emit_local_lbl(lbl1);
            emit("ld      hl,0");
            emit("jr      z,.l%d", lbl2);
            emit("inc     l");
            emit_local_lbl(lbl2);
            break;
        }

        case TOK_OP_OR: {
            // Boolean-OR operation with short circuit
            int lbl1 = gen_local_lbl();
            int lbl2 = gen_local_lbl();
            emit_expr(node->left_node);
            emit("ld      a,h");
            emit("or      l");
            emit("jr      nz,.l%d", lbl1);
            emit_expr(node->right_node);
            emit("ld      a,h");
            emit("or      l");
            emit_local_lbl(lbl1);
            emit("ld      hl,1");
            emit("jr      nz,.l%d", lbl2);
            emit("dec     l");
            emit_local_lbl(lbl2);
            break;
        }

        case TOK_FUNC_ARG: {
            // Argument should be pushed in reversed order
            if (node->right_node)
                emit_expr(node->right_node);
            emit_expr(node->left_node);
            emit("push    hl");
            arg_count++;
            break;
        }

        case TOK_FUNC_CALL: {
            arg_count = 0;
            if (node->right_node)
                emit_expr(node->right_node);

            uint8_t count = arg_count;

            emit("call    _%s", node->left_node->sym->name);
            while (count--) {
                // Clean up stack
                emit("pop     af");
            }
            break;
        }

        default:
            printf("Error: %d (%c)!\n", node->op, node->op);
            syntax_error();
            break;
    }
}

static void parse_compound(void) {
    expect_ack('{');

    while (1) {
        int token = get_token();
        if (token == '}') {
            // End of compound statement
            ack_token();
            break;

        } else if (token == TOK_RETURN) {
            ack_token();
            printf("Return!\n");
            token = get_token();
            if (token != ';') {
                struct expr_node *node = parse_expression();
                emit_expr(node);
            }
            emit("jp      .return");
            expect_ack(';');

        } else {
            struct expr_node *node = parse_expression();
            emit_expr(node);
            expect_ack(';');
        }
    }
}

void parse(void) {
    while (1) {
        int token = get_token();
        if (token == TOK_EOF)
            break;

        if (token == TOK_IDENTIFIER) {
            ack_token();

            // Function definition
            expect_ack('(');
            printf("- Function: %s\n", tok_strval);
            symbol_add(SYMTYPE_FUNC, tok_strval, 0);
            emit_lbl(tok_strval);
            while (1) {
                token = get_token();
                if (token == TOK_CHAR || token == TOK_INT) {
                    uint8_t type = token;
                    ack_token();
                    expect(TOK_IDENTIFIER);
                    printf("  - Argument: %s  (type: %d)\n", tok_strval, type);
                    ack_token();
                }

                token = get_token();
                if (token == ')') {
                    ack_token();
                    break;
                }
                if (token == ',') {
                    ack_token();
                } else {
                    error("Expected comma");
                }
            }

            emit("push    ix");
            emit("ld      ix,0");
            emit("add     ix,sp");

            expect('{');
            parse_compound();

            output_puts(".return:\n", 0);
            emit("ld      sp,ix");
            emit("pop     ix");
            emit("ret");

        } else if (token == TOK_CHAR || token == TOK_INT) {
            uint8_t type = token;
            ack_token();
            expect(TOK_IDENTIFIER);
            printf("  - Variable: %s  (type: %d)\n", tok_strval, type);

            uint8_t symtype = SYMTYPE_GLOBAL | ((token == TOK_CHAR) ? SYMTYPE_VAR_CHAR : SYMTYPE_VAR_INT);
            symbol_add(symtype, tok_strval, 0);

            sprintf(tmpbuf, "_%s:\n", tok_strval);
            output_puts(tmpbuf, 0);
            ack_token();

            int value = 0;

            token = get_token();
            if (token == '=') {
                ack_token();
                struct expr_node *node = parse_expression();
                if (!node || node->op != TOK_CONSTANT)
                    syntax_error();
                value = node->val;
            }

            if (type == TOK_CHAR) {
                sprintf(tmpbuf, "    defb %d\n", value);
            } else {
                sprintf(tmpbuf, "    defw %d\n", value);
            }
            output_puts(tmpbuf, 0);

            expect_ack(';');

        } else {
            syntax_error();
        }
    }

    emit("\n; --- Support functions ---");
    if (flags & FLAGS_USES_MULTSI) {
        emit_lbl("_multsi");
        emit("; To be implemented");
        emit("ret");
    }
    if (flags & FLAGS_USES_DIVSI) {
        emit_lbl("_divsi");
        emit("; To be implemented");
        emit("ret");
    }
    if (flags & FLAGS_USES_MODSI) {
        emit_lbl("_modsi");
        emit("; To be implemented");
        emit("ret");
    }
    if (flags & FLAGS_USES_SHL) {
        emit_lbl("_shl");
        emit("; To be implemented");
        emit("ret");
    }
    if (flags & FLAGS_USES_SHR) {
        emit_lbl("_shr");
        emit("; To be implemented");
        emit("ret");
    }
}
