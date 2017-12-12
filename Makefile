#
#  Copyright (c) 2017 - Present  Jeong Han Lee
#  Copyright (c) 2017 - Present  European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
#
# Author  : Jeong Han Lee
# email   : han.lee@esss.se
# Date    : Tuesday, December 12 13:47:08 CET 2017
# version : 0.3.0
#
TOP:=$(CURDIR)

ifneq (,$(findstring dev,$(MAKECMDGOALS)))
include $(TOP)/configure/CONFIG_DEV
else
include $(TOP)/configure/CONFIG
endif

-include $(TOP)/$(E3_ENV_NAME)/$(E3_ENV_NAME)

include $(TOP)/configure/MK_DEFINES

include $(TOP)/configure/BUILD_E3

include $(TOP)/configure/BUILD_DB

# Build Rule for Community EPICS Building
include $(TOP)/configure/BUILD_EPICS

# Build Rule for Development Mode
ifneq (,$(findstring dev,$(MAKECMDGOALS)))
include $(TOP)/configure/BUILD_DEV
endif


