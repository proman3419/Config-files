#!/usr/bin/env python3
import argparse
from os import walk, mkdir
from os.path import isfile, join, relpath, dirname, isdir, isfile
from shutil import copyfile
from time import sleep


def check_non_negative_f(value):
    fvalue = float(value)
    if fvalue < 0:
        raise argparse.ArgumentTypeError("%s is an invalid non negative float value" % value)

    return fvalue


def get_args():
    arg_parser = argparse.ArgumentParser(
        description='''Script for making a backup of a specified directory''', formatter_class=argparse.RawTextHelpFormatter)

    arg_parser.add_argument(
        'src_path', type=str, help='Path to the directory to backup')
    arg_parser.add_argument(
        'dest_path', type=str, help='Path to the directory where to store the backup')
    arg_parser.add_argument(
        '-r', action='store_true', help='Recursive backup')
    arg_parser.add_argument(
           '--copy_sleep', type=check_non_negative_f, default=0, help='Seconds to wait after each copied file')

    return arg_parser.parse_args()


def fail_str(s):
    return f"[FAIL] {s}"


def backup(args, src_path, dest_path):
    for (dir_path, dir_names, file_names) in walk(src_path):
        d_dest_path = join(args.dest_path, relpath(dir_path, args.src_path))

        if not isdir(d_dest_path):
            status_str = f"CREATE DIR | {d_dest_path}"
            try:
                mkdir(d_dest_path)
                print(status_str)
            except:
                print(fail_str(status_str))
                input()

        for f in file_names:
            f_src_path = join(dir_path, f)
            f_dest_path = join(args.dest_path, relpath(f_src_path, args.src_path))

            if not isfile(f_dest_path):
                try:
                    status_str = f"COPY FILE | {f_src_path}\t TO \t{f_dest_path}"
                    copyfile(f_src_path, f_dest_path)
                    print(status_str)
                    sleep(args.copy_sleep)
                except:
                    print(fail_str(status_str))
                    input()
            else:
                print(f"OMIT FILE | FOUND {f_src_path}\t AS \t{f_dest_path}")

        if not args.r:
            break


args = get_args()
backup(args, args.src_path, args.dest_path)
