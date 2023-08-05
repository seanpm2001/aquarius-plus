#pragma once

#include "Common.h"
#include "USBInterface.h"
#include "HIDReportDescriptor.h"
#include "HIDReportHandler.h"
#include <usb/usb_host.h>

class USBInterfaceHID : public USBInterface {
public:
    USBInterfaceHID(USBDevice *device);
    virtual ~USBInterfaceHID();

    bool init(const void *ifDesc, size_t ifDescLen);

    enum CollectionType {
        CTPhysical      = 0x00, // CP
        CTApplication   = 0x01, // CA
        CTLogical       = 0x02, // CL
        CTReport        = 0x03,
        CTNamedArray    = 0x04, // NAry
        CTUsageSwitch   = 0x05, // US
        CTUsageModifier = 0x06  // UM
    };

protected:
    // virtual void InterruptData(EHCIQueueElementTransferDescriptor *qtd);
    // uint8_t          *interruptBuf;

    static void _inTransferCb(usb_transfer_t *transfer);
    void        inTransferCb(usb_transfer_t *transfer);

    HIDReportHandler *reportHandlers = nullptr;
};
