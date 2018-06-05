#!/bin/bash

docker run --rm -it -v $(pwd)/example:/root/example diluka/openmvgmvs bash -c "mvgmvs ~/example/sceaux-castle/images ~/example/sceaux-castle/output"