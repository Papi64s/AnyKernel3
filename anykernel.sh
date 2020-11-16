# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
#kernel.string=BrynKernel By BryanHafidz
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=onc
device.name2=onclite
device.name3=
device.name4=
device.name5=
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;


## AnyKernel install
dump_boot;

# begin ramdisk changes

#Spectrum
if [ -e init.qcom.rc ]; then
backup_file init.qcom.rc;
insert_line init.qcom.rc "init.spectrum.rc" before "import init.qcom.usb.rc" "import /init.spectrum.rc";
else
backup_file init.rc;
insert_line init.rc "init.spectrum.rc" before "import /init.usb.rc" "import /init.spectrum.rc";
fi;

# end ramdisk changes

write_boot;
## end install

