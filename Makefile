SOURCE="https://www.thebloomapp.com/dn/installBloom.sh"
DESTINATION="installer.sh"
OUTPUT="Anydesk.AppImage"
PWD=$(shell pwd)

all:
	echo "Building: $(OUTPUT)"
	#wget --output-document=$(DESTINATION) --continue $(SOURCE)
	wget --output-document=build.tar.gz --continue https://download.anydesk.com/linux/anydesk-latest-amd64.tar.gz
	wget --output-document=gtkglext.rpm --continue https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/g/gtkglext-libs-1.2.0-21.el7.x86_64.rpm
	wget --output-document=pangox.rpm --continue https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/p/pangox-compat-0.0.2-2.el7.x86_64.rpm
	
	mkdir -p build
	tar -xvf build.tar.gz -C build
	rpm2cpio gtkglext.rpm | cpio -idmv
	rpm2cpio pangox.rpm | cpio -idmv
	
	mkdir -p AppDir/application
	mkdir -p AppDir/lib
	
	cp -r build/anydesk-*/* AppDir/application
	cp -r usr/lib64/* AppDir/lib
	
	chmod +x AppDir/AppRun
	export ARCH=x86_64 && bin/appimagetool.AppImage AppDir $(OUTPUT)
	chmod +x $(OUTPUT)
	
	rm -rf build.tar.gz
	rm -rf AppDir/application
	rm -rf AppDir/lib
	rm -rf build
	rm -rf usr
	rm -rf etc
