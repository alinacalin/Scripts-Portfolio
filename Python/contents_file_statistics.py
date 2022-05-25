#!/usr/bin/python3
import sys
import urllib.request
import gzip
import re
import os


# The architectures list accepted based on the current directory Contents files
SARCH_LIST = {'all', 'amd64', 'arm64', 'armel', 'armhf', 'i386',
              'mips64el', 'ppc64el', 's390x', 'source'}

def parse(sarch):

    # Download the file
    mirror = "http://ftp.uk.debian.org/debian/dists/stable/main/"
    filename = "Contents-"+sarch+".gz"
    print("Downloading "+mirror+filename)
    print("This might take a while...")
    urllib.request.urlretrieve(mirror+filename, filename)
    print("File downloaded successfully.")
    print("Parsing file, this will take a while...")

    # Decompress and parse
    package_freq = dict()
    with gzip.open(filename, 'rb') as f:
        for line in f:
            line = line.strip().decode("utf-8")  # get rid of b and \n
            # Use regex to check the line format.
            ok = bool(re.search(r'^[\S\s]+\s+\S+,?\S', line))
            if not ok:
                print("Non matching line to be ignored:" + line)
            else:
                # Get the list of packages, considering file can have spaces
                *_, packages = line.split()
                for package in packages.split(','):
                    if package in package_freq:
                        package_freq[package] += 1
                    else:
                        package_freq[package] = 1

    print("Top 10 packages:")
    # Sort the dictionary and select top 10
    top_packages = sorted(package_freq.items(), key=lambda x: x[1],
                          reverse=True)[:10]
    for p, v in top_packages:
        print('{:<55} {:>12}'.format(p, v))

    # Clean-up file
    os.remove(filename)
    return None


def main():
    # Validate the input argument
    try:
        sarch = sys.argv[1]
    except IndexError:
        raise SystemExit(f"Usage: {sys.argv[0]} <architecture>")

    # Validate architecture in the current files list.
    if sarch in SARCH_LIST:
        parse(sarch)
    else:
        print("Valid arguments are: ")
        print(SARCH_LIST)
        raise SystemExit(f"Usage: {sys.argv[0]} <architecture>")


if __name__ == '__main__':
    rc = 1
    try:
        main()
        rc = 0
    except Exception as e:
        print('Error: %s' % e, file=sys.stderr)
    sys.exit(rc)
