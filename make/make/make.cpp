// make.cpp : 此檔案包含 'main' 函式。程式會於該處開始執行及結束執行。
//

#include <iostream>
#include <string>
#include <fstream>
#include<algorithm>
#include< cstring >
#include<vector>
//#include <wiringPi.h> //to include gpio for rbpi

using namespace std;
// wiringPiSetup () ;
//  pinMode(LED, PWM_OUTPUT) ;
//  pwmWrite(LED, 255);
//*****************************
//  pinMode (0, OUTPUT) ;
//  digitalWrite(0, HIGH) ;
struct Color {
    int R, G, B;
};

struct Color_mode {
    Color color;
    string mode_name;
};


struct Color_method {
    Color hex_str_2_rgb(string hexstring) {
        cout << hexstring << endl;
        long number = (long)strtol(&hexstring[0], NULL, 16);
        Color c;
        c.R = (number >> 16);
        c.G = (number >> 8 & 0xFF);
        c.B = (number & 0xFF);
        return c;
    }
    string rgb_2_hex_str(Color rgb) {
        char hex_char[] = { "0123456789ABCDEF" };
        string str_rgb = "", t = "";
        str_rgb.push_back(hex_char[(rgb.R / 16)]);
        str_rgb.push_back(hex_char[(rgb.R % 16)]);
        str_rgb.push_back(hex_char[(rgb.G / 16)]);
        str_rgb.push_back(hex_char[(rgb.G % 16)]);
        str_rgb.push_back(hex_char[(rgb.B / 16)]);
        str_rgb.push_back(hex_char[(rgb.B % 16)]);
        return str_rgb;
    }
};

/*
struct File_method{
    string Read_file(){
        //https://www.w3schools.com/cpp/cpp_files.asp
        // 上面為開啟檔案的寫法
        //本函式 你需要把檔案的東西讀出來然後作為字串存到string_content
        ofstream MyFile("storage.txt");
        string  string_content="";
        MyFile.close();
        return string_content;
    }
    bool Safe_file(string content){
        //本函式 你需要把字串content 的存到MyFile的物件裡面
        ofstream MyFile("storage.txt");
        MyFile.close();
        return true;
    }

};*/
struct File_method {
    string Read_file() {
        //https://www.w3schools.com/cpp/cpp_files.asp
        // 上面為開啟檔案的寫法
        //本函式 你需要把檔案的東西讀出來然後作為字串存到string_content
        ifstream MyReadFile("storage.txt");
        string  string_content, t;
        while (getline(MyReadFile, t)) {
            t += ";";
            string_content+=t;
            
        }
        MyReadFile.close();
        return string_content;
    }
    bool Safe_file(string content) {
        //本函式 你需要把字串content 的存到MyFile的物件裡面
        ofstream MyReadFile("storage.txt");
        MyReadFile << content;
        
        MyReadFile.close();
        return true;
    }

};

class gpio {
    File_method fm;
    Color_method cm;
    Color_mode c_mode[6]; //有五個模式 模式6為自訂，程式不設定，只儲存
    string vars;
public:
    gpio() {
        //在這邊你需要讀取檔案，把檔案裡面的變數變成程式儲存的變數
        // 1. 讀取檔案，2.把字串裡的文字變成變數
        

        //for (int i = 0; i < 6; i++) c_mode[i].mode_name = ""; // 要先把所有的name 進行初始化
        vars = fm.Read_file();
        string buf[12];
        int current = 0;
        int next;
        int cut= vars.find_first_of(",;", current);
        int i = 0;
        while (1)
        {
            next = vars.find_first_of(",;", current);
            if (next != current)
            {
                string tmp = vars.substr(current, next - current);
                if (tmp.size() != 0)  //忽略空字串
                {  
                    if (i < 12)
                    buf[i] = (tmp);
                    i++;
                }
            }
            if (next == string::npos) break;
            current = next+1; //下次由 next + 1 的位置開始找起。
        }

        for (string tmp : buf)
        {
            for (int i = 0; i<6; i++)
            {
                //i % 2;
                
                cout << c_mode[i].mode_name;
            }
            c_mode[i].mode_name = tmp;
            
        }

        for (int i = 0; i < 6; i++)
        {
            //cm.hex_str_2_rgb = c_mode[i].color;
            //cout<<c_mode[i].mode_name;
        }
        
        //c_mode[0].color = cm.hex_str_2_rgb( vars 讀取出來的色碼);
        //c_mode[0].mode_name = vars 讀出來的情境名稱;


        //wiringPiSetup();
        cout << "gpio init";
    }

    

    ~gpio() {
        //在這邊會需要將所有變數變成字串存到檔案裡面
        string contents = "";
        for (int i = 0; i < 6; i++)
        {
            c_mode[i].mode_name = vars;
        }

        fm.Safe_file(contents);
    }

    int set_rgb(Color c) {
        //  可以讀取 Color內數值並且透過 pwmWrite(腳位, 數值); 進行設定 結束時回傳LED會顯示的模式

        return 6;
    }

    int set_rgb(string mode_name) {
        //  可以讀取 Color_mode 內數值並且透過 pwmWrite(腳位, 數值); 進行設定ＬＥＤ模式 結束時回傳LED會顯示的模式
        // 要先搜尋c_mode 裡面哪一個 mode_name == mode_name 然後回傳是在mode_name的第幾個 index 從0開始
        return 6;
    }


    void set_motor() {
        // 先讀取檔案，查看檔案內motor是０還是１，０為目前關閉，１為目前開啟
    }


    int set_rgb_mode(string mode_name, Color c) {
        // 查看c_mode內每一個mode＿name是不是有重複，如果有重複，就覆蓋後面的c，如果沒有重複&&沒有滿五種
        int index_mode = -1;

        for (int i = 1; i < 6; i++)
        {
            for (int j = 0; j < 6 - i; j++)
            {
                if (c_mode == c_mode)   //如果一樣就覆蓋
                {
                    string colorcode = cm.rgb_2_hex_str(c);
                }
                //缺 如果沒有重複&&沒有滿五種
            }

        }


        return index_mode;
    }

    void get_rgb_mode() {};

};





int main(int argc, char* argv[]) {

    // Color_method cm;
    // string hex_str(argv[1]);
    // Color c = cm.hex_str_2_rgb(hex_str);
    // cout << c.R <<"　" << c.G << "　" << c.B << "　" << endl;
    // cout << cm.rgb_2_hex_str(c) << endl;
    File_method aaaa;
    //cout << aaaa.Safe_file(aaaa.Read_file()) << endl;
    aaaa.Safe_file("模式1,FFAA12;模式２, FFAA12;模式３, FFAA12;模式４, FFAA12;模式５, FFAA12;自訂, FFAA12");
    gpio();
    /*
    gpio iopin;
    Color c;
    c.R = 50;
    c.G = 100;
    c.B = 255;
    iopin.set_rgb_mode("情境二", c);
    */

    return 0;
}
