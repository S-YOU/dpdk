proc rte_strsplit*(string: cstring; stringlen: cint; tokens: cstringArray;
                  maxtokens: cint; delim: char): cint {.importc, header: "rte_string_fns.h".}
