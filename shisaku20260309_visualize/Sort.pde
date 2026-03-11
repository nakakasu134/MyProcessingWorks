void Sort(Element[] elements) {
  int len=elements.length;
  int[] area=new int[len];
  area[0]=len;

  for (int confirmed=0; confirmed<len; confirmed++) {
    boolean countBottom=false;
    while (area[confirmed]>1) {
      int currentArea=area[confirmed];
      int count=0;
      for (int i=0; i<currentArea-1; i++) {
        int bottom=confirmed+count;
        int top=confirmed+currentArea-i+count-1;
        if (elements[bottom].value>elements[top].value) {
          Element temp=elements[bottom];
          elements[bottom]=elements[top];
          elements[top]=temp;
          countBottom=!countBottom;
        }
        if (countBottom)count++;
      }
      area[confirmed]=count;
      area[confirmed+count]=1;
      if (count+1<currentArea)area[confirmed+count+1]=currentArea-count-1;
    }
  }
}
