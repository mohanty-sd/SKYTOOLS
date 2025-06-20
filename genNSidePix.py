#!/usr/bin/env python3
import sys
import healpy as hp
import numpy as np

# Help instructions
if len(sys.argv) == 2 and sys.argv[1] in ('-h', '--help'):
    print("""
Usage: python3 genNsidePix.py <nside> <output_file>

Arguments:
  <nside>        HEALPix nside parameter (must be 1 or a power of 2)
  <output_file>  Output file to save (theta, phi) pairs

Options:
  -h, --help     Show this help message and exit

This script generates HEALPix pixel centers (theta, phi) for a given nside and saves them as a two-column CSV file.
""")
    sys.exit(0)

if len(sys.argv) != 3:
    print("Usage: python3 genNSidePix.py <nside> <output_file>")
    sys.exit(1)

try:
    nside = int(sys.argv[1])
    if nside < 1 or (nside & (nside - 1)) != 0:
        print("Error: nside must be 1 or a power of 2.")
        sys.exit(1)
except ValueError:
    print("Error: nside must be an integer.")
    sys.exit(1)

output_file = sys.argv[2]

npix = hp.nside2npix(nside)
theta, phi = hp.pix2ang(nside, np.arange(npix), nest=False)

# Save as two-column CSV (theta, phi)
with open(output_file, 'w') as f:
    for t, p in zip(theta, phi):
        f.write(f"{t},{p}\n")

print(f"Saved {npix} pixels (theta, phi) to {output_file}")
