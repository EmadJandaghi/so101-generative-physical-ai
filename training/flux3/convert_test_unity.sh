#!/bin/bash
#SBATCH --job-name=flux_convert
#SBATCH --partition=cpu
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=01:00:00
#SBATCH --output=/work/pi_pstegagno_uri_edu/so101_flux3/convert_%j.out

/work/pi_pstegagno_uri_edu/so101_flux3/env/bin/python /work/pi_pstegagno_uri_edu/so101_flux3/convert_30hz.py
