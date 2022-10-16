#!/usr/bin/env python3

import argparse
from pathlib import Path
from typing import List


def clean():
    paths_to_ignore = []
    with open("path_ignore.txt", "r") as ignore_file:
        for l in ignore_file:
            paths_to_ignore.append(Path(l.rstrip()))

    base_path = Path(".")
    to_be_deleted: List[Path] = []
    print("### FILES TO BE SKIPPED ###")
    for i in base_path.glob("**/*.pdf"):
        for ignored_path in paths_to_ignore:
            if (ignored_path in i.parents) or (ignored_path.samefile(i)):
                print(f"{i.as_posix()}")
            else:
                to_be_deleted.append(i)

    print("### FILES TO BE CLEANED UP ###")
    for deletable in to_be_deleted:
        print(deletable)
        # deletable.unlink()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        "build.py", description="Build and clean script for the repo"
    )
    parser.add_argument("-c", "--clean", dest="clean", action="store_true")

    args = vars(parser.parse_args())
    if "clean" in args.keys():
        clean()
