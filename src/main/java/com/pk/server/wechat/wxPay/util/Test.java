package com.pk.server.wechat.wxPay.util;

import java.util.ArrayList;
import java.util.Random;

public class Test {

    public static void main(String[] args){
        for(int i=0;i<10000;i++){
            get();
        }
    }
    public  static String  get(){
        ArrayList<Object> array=new ArrayList<>();
        Random rand =new Random();
        for(int i=0;i<4;i++){
            int choice=rand.nextInt(3);
            switch (choice) {
                case 0:
                    int num=rand.nextInt(9);
                    array.add(num);
                    break;
                case 1:
                    int num2=rand.nextInt(25)+65;
                    char low=(char)num2;
                    array.add(low);
                    break;
                case 2:
                    int num3=rand.nextInt(25)+65;
                    char high=(char)num3;
                    array.add(high);
                    break;
                default:
                    break;
            }
        }
        System.out.println("验证码：");
        for (Object object : array) {
            System.out.print(object);
        }

        return array.toString();
    }
}
