// RUN: %target-run-simple-swift
// REQUIRES: executable_test

#if os(OSX) || os(iOS) || os(watchOS) || os(tvOS)
  import Darwin
#elseif os(Linux) || os(FreeBSD) || os(PS4) || os(Android) || os(Fuchsia)
  import Glibc
#endif

// drand48,mrand48,etc are only visible if _XOPEN_SOURCE (or better) is defined
// on Glibc
let a = drand48()
print(a)
#if os(Linux) || os(FreeBSD) || os(PS4) || os(Android) || os(Fuchsia)
// mrand48 and lrand48 is explictly set to __swift_unavailable on Darwin libc
// favoring arc4random() instead
let b = mrand48()
print(b)
let c = lrand48()
print(c)
#endif


// strptime is only visible if _XOPEN_SOURCE (or better) is defined on Glibc
var stm = tm()
strptime("2011-02-31", "%Y-%m-%d", &stm)
var stt : time_t = mktime(&stm)
var string_time = ctime(&stt)

print(String(cString:string_time!))
