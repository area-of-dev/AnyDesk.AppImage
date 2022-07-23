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

.PHONY: all

all: clean init

	mkdir --parents $(PWD)/build/Boilerplate.AppDir/anydesk
	$(PWD)/bin/Apprepo.AppImage --destination=$(PWD)/build appdir boilerplate \
			libgtk2.0-0 libatk1.0-0 libatk-bridge2.0-0 gconf2 \
			libgtk-3-0  libpango-1.0-0 libpangox-1.0-0 libgtkglext1

	wget --output-document=$(PWD)/build/build.tar.gz https://download.anydesk.com/linux/generic-linux/anydesk-5.5.6-amd64.tar.gz
	tar -xvf $(PWD)/build/build.tar.gz -C $(PWD)/build/

	cp --force --recursive $(PWD)/build/anydesk-*/*   $(PWD)/build/Boilerplate.AppDir/anydesk

	echo '' 																		>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' 																		>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'LD_LIBRARY_PATH=$${LD_LIBRARY_PATH}:$${APPDIR}/anydesk' 					>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'export LD_LIBRARY_PATH=$${LD_LIBRARY_PATH}' 								>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' 																		>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' 																		>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'exec $${APPDIR}/anydesk/anydesk "$${@}"' 								    >> $(PWD)/build/Boilerplate.AppDir/AppRun

	rm --force $(PWD)/build/Boilerplate.AppDir/*.svg      || true
	rm --force $(PWD)/build/Boilerplate.AppDir/*.desktop  || true
	rm --force $(PWD)/build/Boilerplate.AppDir/*.png      || true

	cp --force $(PWD)/AppDir/*.png 			$(PWD)/build/Boilerplate.AppDir/ || true
	cp --force $(PWD)/AppDir/*.desktop 		$(PWD)/build/Boilerplate.AppDir/ || true
	cp --force $(PWD)/AppDir/*.svg 			$(PWD)/build/Boilerplate.AppDir/ || true


	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/Boilerplate.AppDir $(PWD)/AnyDesk.AppImage
	chmod +x $(PWD)/AnyDesk.AppImage

init:
	mkdir --parents $(PWD)/bin

	wget https://apprepo.de/appimage/download/apprepo \
		--output-document=$(PWD)/bin/Apprepo.AppImage
	chmod +x $(PWD)/bin/Apprepo.AppImage

	wget https://github.com/AppImage/AppImageKit/releases/download/13/appimagetool-x86_64.AppImage \
		--output-document=$(PWD)/bin/appimagetool.AppImage
	chmod +x $(PWD)/bin/appimagetool.AppImage

clean:
	rm -rf $(PWD)/*.AppImage
	rm -rf $(PWD)/bin/*
	rm -rf $(PWD)/build
