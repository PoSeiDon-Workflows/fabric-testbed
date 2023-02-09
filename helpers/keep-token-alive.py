#!/usr/bin/env python3

from fabrictestbed_extensions.fablib.fablib import FablibManager as fablib_manager

fablib = fablib_manager()

try:
    print(fablib.list_sites())
    #fields=["Name", "Cores Available", "RAM Available", "Basic NIC Available", "ConnectX-5 Available", "ConnectX-6 Available"]))
except Exception as e:
    print(f"Exception: {e}")
