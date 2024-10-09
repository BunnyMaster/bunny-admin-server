package cn.bunny.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

class Solution {
    public List<List<String>> groupAnagrams(String[] strs) {
        HashMap<String, List<String>> hashMap = new HashMap<>();

        for (String str : strs) {
            char[] charArray = str.toCharArray();
            Arrays.sort(charArray);

            String value = String.valueOf(charArray);
            if (hashMap.containsKey(value)) {
                hashMap.get(value).add(str);
            } else {
                hashMap.put(value, List.of(str));
            }
        }

        return hashMap.values().stream().toList();
    }
}