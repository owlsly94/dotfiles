#!/bin/bash
export MOZ_ENABLE_WAYLAND=1
export MOZ_WEBRENDER=1
export MOZ_ENABLE_HARDWARE_VIDEO_DECODING=1
exec zen-browser "$@"
