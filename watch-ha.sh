#!/bin/bash
watch kubectl get node,all,pvc,pv,deployment -o wide
