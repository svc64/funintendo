#include <substrate.h>
#include <mach-o/dyld.h>
typedef void (*mshookmemory_ptr_t)(void *target, const void *data, size_t size);
%ctor {
char data[16];
char toFind[16] = {0xF4,0x4F,0xBE,0xA9,0xFD,0x7B,0x01,0xA9,0xFD,0x43,0x00,0x91,0xFF,0x43,0x2B,0xD1};
int found = 0;
int64_t offset = 0;
int64_t slide = _dyld_get_image_vmaddr_slide(0);
while(found!=1) {
    memcpy(&data, (const void *)slide+0x100000000+offset, 16);
    if(memcmp(data, toFind, 16)==0) {
        found = 1;
        NSLog(@"found!");
        NSLog(@"%lld", 0x100000000+offset);
    } else {
        offset++;
    }
}
mshookmemory_ptr_t MSHookMemory_ = (mshookmemory_ptr_t)MSFindSymbol(NULL, "_MSHookMemory");
const uint8_t hack[] = {
    0xc0, 0x03, 0x5f, 0xd6
};
MSHookMemory_((void *)slide+0x100000000+offset, hack, sizeof(hack));
}
