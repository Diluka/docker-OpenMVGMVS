#!/bin/bash

docker run --rm -it -v $(pwd)/example:/root/example openmvgmvs bash -c "mvgmvs ~/example/sceaux-castle/images ~/example/sceaux-castle/output"