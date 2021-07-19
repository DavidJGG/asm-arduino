void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial1.begin(9600);
  pinMode(7, OUTPUT);
  pinMode(8, OUTPUT);
  DDRF = B11111111;
}

char str[100];
char letra = '\0';
int pos=0;
void loop() {
/*  char arr[]="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  int i=0;
  while(true){
    Serial.write("Simon");
    i++;
    delay(1000);
    if(i==26)i=0;
  }*/
  // put your main code here, to run repeatedly:
  if(Serial.available()>0){
    letra=Serial.read();
    str[pos]=letra;
    pos++; 
  
  }

  if(letra=='\r'){
    Serial1.print("Procesando: ");
    Serial1.println(str);
    procesarStr();
    limpiarStr();
    pos=0;
    letra='\0';
  }
}

void procesarStr(){
  if(str[0]=='l'){
    /* 
     * led1e -> enciende led1
     * led1a -> apaga led1
     * led2e -> enciende led2
     * led2a -> apaga led2
    */
    if(str[3]=='1' && str[4]=='e') {digitalWrite(8, HIGH); Serial.write("Arduino dice: Led 1 encendido-"); return;}
    if(str[3]=='1' && str[4]=='a') {digitalWrite(8, LOW); Serial.write("Arduino dice: Led 1 apagado-"); return;}
    if(str[3]=='2' && str[4]=='e') {digitalWrite(7, HIGH); Serial.write("Arduino dice: Led 2 encendido-"); return;}
    if(str[3]=='2' && str[4]=='a') {digitalWrite(7, LOW); Serial.write("Arduino dice: Led 2 apagado-"); return;}
  }else if(str[0]=='d'){
    int val = String(str[1]).toInt();
    PORTF = getBytes(val);
    Serial.write("Display encendido-");
    return;
  }else if(str[0]=='\r'){
    Serial.write("-"); //indica a ASM que deje de escuchar
    return;
  }

  Serial.write("Arduino no conoce el comando: ");
  Serial.write(str);
  Serial.write("-");
}

void limpiarStr(){
  for(int i=0; i<100; i++){
    str[i]='\0';
  }
}

byte getBytes(int val){
  if(val==0) return B1111110;
  if(val==1) return B0110000;
  if(val==2) return B1101101;
  if(val==3) return B1111001;
  if(val==4) return B0110011;
  if(val==5) return B1011011;
  if(val==6) return B1011111;
  if(val==7) return B1110000;
  if(val==8) return B1111111;
  if(val==9) return B1110011;
}
