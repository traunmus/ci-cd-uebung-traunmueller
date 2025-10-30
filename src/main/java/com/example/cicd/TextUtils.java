package com.example.cicd;

public class TextUtils {

    public static boolean isPalindrome(String input) {
    if (input == null) return false;
    String normalized = input.toLowerCase();
    String reversed = new StringBuilder(normalized).reverse().toString();
    return normalized.equals(reversed);
}

    // Leerer Catch-Block + sehr generische Exception
    public static int safeParseInt(String s) {
        try {
            return Integer.parseInt(s);
        } catch (Exception e) { 
            // absichtlich leer gelassen
        }
        return 0; // „Fallback“ – diskutabel
    }
}
