#include <iostream>
#include <string>
#include <fstream>
#include <wiringPi.h> //to include gpio for rbpi

using namespace std;
// wiringPiSetup () ;
//  pinMode(LED, PWM_OUTPUT) ;
//  pwmWrite(LED, 255);
//*****************************///////
//  pinMode (0, OUTPUT) ;
//  digitalWrite(0, HIGH) ;
struct Color {
    int R, G, B;
};


struct Color_mode{
	Color mode;
	string mode_name; 
};

struct Color_method{
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
        string str_rgb = "", t="";
        str_rgb.push_back(hex_char[(rgb.R / 16)]); 
        str_rgb.push_back(hex_char[(rgb.R % 16)]);
        str_rgb.push_back(hex_char[(rgb.G / 16)]); 
        str_rgb.push_back(hex_char[(rgb.G % 16)]);
        str_rgb.push_back(hex_char[(rgb.B / 16)]); 
        str_rgb.push_back(hex_char[(rgb.B % 16)]);
        return str_rgb;
    }
};
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

};

class gpio{
	Color_method cm;
	File_method fm;
	Color_mode c_mode[6]; //有五個模式 模式6為自訂，程式不設定，只儲存
    string vars;
    public:
    gpio(){
		//在這邊你需要讀取檔案，把檔案裡面的變數變成程式儲存的變數
		// 1. 讀取檔案，2.把字串裡的文字變成變數

		for(int i =0;i<5;i++) c_mode[i].mode_name = ""; // 要先把所有的name 進行初始化
        vars = fm.Read_file();


        wiringPiSetup();
        cout<< "gpio init";
    }

    ~gpio(){
        //在這邊會需要將所有變數變成字串存到檔案裡面
        string contents="";
        fm.Safe_file(contents);
    }

	int set_rgb(Color c){
        //  可以讀取 Color內數值並且透過 pwmWrite(腳位, 數值); 進行設定 結束時回傳LED會顯示的模式

        return 6;
    }

    int set_rgb(string mode_name){
        //  可以讀取 Color_mode 內數值並且透過 pwmWrite(腳位, 數值); 進行設定ＬＥＤ模式 結束時回傳LED會顯示的模式
        // 要先搜尋c_mode 裡面哪一個 mode_name == mode_name 然後回傳是在mode_name的第幾個 index 從0開始
        return 6;
    }
    
    /*
    void set_motor(){
        // 先讀取檔案，查看檔案內motor是０還是１，０為目前關閉，１為目前開啟
    }
    */
	
	void set_rgb_mode(string mode_name, Color c){
		// 查看c_mode內每一個mode＿name是不是有重複，如果有重複，就覆蓋後面的c，如果沒有重複&&沒有滿五種
	}

    void get_rgb_mode()

};

int main(int argc, char* argv[]) {

    Color_method cm;
    string hex_str(argv[1]);
    Color c = cm.hex_str_2_rgb(hex_str);
    cout << c.R <<"　" << c.G << "　" << c.B << "　" << endl;
    cout << cm.rgb_2_hex_str(c) << endl;
    return 0;
}