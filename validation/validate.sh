#!/bin/bash

python3 -m venv /tmp/.venv
source /tmp/.venv/bin/activate
pip install hardeneks
hardeneks --export-html report.html
open report.html

# Read https://aws.amazon.com/blogs/containers/hardeneks-validating-best-practices-for-amazon-eks-clusters-programmatically/