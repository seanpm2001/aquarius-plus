������������ BASPRG������������ 9�� AqPlus Tile Scroll Demo A9�� Set starting tile positions M9�X�0:Y�0 q9� Set Tilemap HScroll Registers �9M�225:N�226 �9B� Load tile data into Page 20 �9L�"data/ss.til",@20,0 �9j� Set palette loop �9t� I�0�31 �9~� Update VPALSEL :�� 234,I :�� Update VPALDATA -:�� 235,�(�24576�I) 3:�� Y:�� Set VCTRL to 64x32 tilemap mode e:�� 224,2 z:�� Scroll tileset �:�X�X�1:�X�511�X�0 �:�Q�X�255:R�X�256:�M,Q:�N,R �:�� Uncomment next 2 lines for diag �:�Y�Y�1:�Y�255�Y�0 �:��227,Y ; � ��"" � 1220 ";
� Set VCTRL to text mode .;� 224,1 :;�"data" O;2�"reset-pal.bas"                  