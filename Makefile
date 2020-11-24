# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)

all: clean
	mkdir --parents $(PWD)/build
	mkdir --parents $(PWD)/build/AppDir
	mkdir --parents $(PWD)/build/AppDir/anydesk

	wget --output-document=$(PWD)/build/build.tar.gz https://download.anydesk.com/linux/anydesk-latest-amd64.tar.gz
	tar -xvf $(PWD)/build/build.tar.gz -C $(PWD)/build/

	wget --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/gtk2-2.24.32-4.el8.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/GConf2-3.2.6-22.el8.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/pango-1.42.4-4.el7_7.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/p/pangox-compat-0.0.2-2.el7.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/g/gtkglext-libs-1.2.0-21.el7.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..


	cp --force --recursive $(PWD)/build/usr/* $(PWD)/build/AppDir/
	cp --force --recursive $(PWD)/build/anydesk-*/* $(PWD)/build/AppDir/anydesk
	cp --force --recursive $(PWD)/AppDir/* $(PWD)/build/AppDir

	chmod +x $(PWD)/build/AppDir/AppRun
	chmod +x $(PWD)/build/AppDir/*.desktop

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/AppDir $(PWD)/AnyDesk.AppImage
	chmod +x $(PWD)/AnyDesk.AppImage

clean:
	rm -rf $(PWD)/build
