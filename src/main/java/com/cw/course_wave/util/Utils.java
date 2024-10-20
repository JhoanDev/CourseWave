package com.cw.course_wave.util;
import java.security.*;
import java.math.*;

public class Utils {

    public static String generateMD5(String input) throws Exception {
        MessageDigest digest = MessageDigest.getInstance("MD5");
        digest.update(input.getBytes(), 0, input.length());
        return new BigInteger(1, digest.digest()).toString(16);
    }
}
