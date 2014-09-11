#!/usr/bin/env python
"""Compare configs, and return common and each unique config."""

def parse(path):
    """Return a dict based on the config file."""
    import ConfigParser
    fp = open(path)
    cfg = ConfigParser.ConfigParser()
    cfg.readfp(fp)

    return_dict = {}

    # tuples
    for section in cfg.sections():
        return_dict[section] = cfg.items(section)

    fp.close()

    return return_dict

def compare(cfgs=[]):
    """Given a list of configs, compare and contrast. Return a dict with
    "common" settings, and a list of differences (in the order submitted)."""
    common_dict = {}

    # find the intersection of all config sections
    common_sections = set()
    for k in cfgs[0].keys():
        common_sections.add(k)
    for i in (range(1, len(cfgs) - 1)):
        common_sections.intersection_update({k for k in cfgs[i].keys()})

    # find the intersection of all key/value pairs by common section
    for section in common_sections:
        common_dict[section] = set()

        for opt in cfgs[0][section]:
            common_dict[section].add(opt)

        for i in range(1, len(cfgs) - 1):
            for opt in cfgs[i][section]:
                common_dict[section].intersection_update({t for t in cfgs[i][section]})

    # compare each config against common
    diffs = []
    for cfg in cfgs:
        diff = {}
        diffs.append(diff)
        for section in cfg.keys():
            diff[section] = {t for t in cfg[section]}

            if common_dict.get(section):
                diff[section].difference_update(common_dict[section])

            if len(diff[section]) == 0:
                del diff[section]

    return {
        "common": common_dict,
        "cfgs": diffs
    }

def main():
    import argparse
    import pprint

    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('config_paths', metavar='[path]', nargs='+', help='path to a config file')
    args = parser.parse_args()

    paths = vars(args)['config_paths']

    res = compare(cfgs=[parse(path) for path in paths])
    pprint.pprint(res)


if __name__ == "__main__":
    main()
