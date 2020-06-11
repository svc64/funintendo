#include <substrate.h>
#include <mach-o/dyld.h>
typedef void (*mshookmemory_ptr_t)(void *target, const void *data, size_t size);
%ctor {
mshookmemory_ptr_t MSHookMemory_ = (mshookmemory_ptr_t)MSFindSymbol(NULL, "_MSHookMemory");
const uint8_t hack[] = {
    0xc0, 0x03, 0x5f, 0xd6
};
MSHookMemory_((void *)_dyld_get_image_vmaddr_slide(0)+0x1030120b4, hack, sizeof(hack));
}
