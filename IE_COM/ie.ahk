#include COM_L.ahk 


com_init()
ie := com_CreateObject("InternetExplorer.Application.1") 
; ���ͳ� �ͽ��÷ξ� �������α׷� ��ü����

com_invoke(ie, "top=", 0)
com_invoke(ie, "left=", 0)
com_invoke(ie, "width=", 800)
com_invoke(ie, "height=", 600)
com_invoke(ie, "visible=", 1) 
; ���ͳ� �ͽ����Ѿ� �Ӽ��� visible �Ӽ��� 1��(��, ���̰� ����)

com_invoke(ie, "navigate", "http://www.autohotkey.com") 
; ie �� �޼ҵ�(�Լ�) �� navigate �Լ��� ����(�Ķ���ͷ� �ּҸ� ���ָ� �ȴ�.)

Loop
{
if not (com_invoke(ie, "busy"))   ; ������ �ε嶧���� ��ѷ�
  break
sleep, 100
}

Doc := com_invoke(ie, "Document")
body := com_invoke(doc, "body")
innerhtml := com_invoke(body, "innerHtml")
outerhtml := com_invoke(body, "outerHtml")
;msgbox, %outerhtml%   ; html �ҽ����ϱ�

msgbox, ȭ��Ȯ��, ��� �Ű��� �̾����ϴ�.
bodystyle := com_invoke(body, "style")
com_invoke(ie, "width=", A_ScreenWidth)
com_invoke(ie, "height=", A_screenHeight)
com_invoke(bodystyle, "zoom=", "150%") ; ȭ���� Ȯ���Ͻðڽ��ϴ�.
sleep, 2000
com_invoke(bodystyle, "zoom=", "300%") ; ȭ���� Ȯ���Ͻðڽ��ϴ�.
sleep, 2000
com_invoke(bodystyle, "zoom=", "100%") ; ȭ���� Ȯ���Ͻðڽ��ϴ�.
sleep, 2000
msgbox, �̹����� ���� ���������� ��ũ 5���� ã�Ƴ��ڽ��ϴ�.

links := com_invoke(doc, "getElementsByTagName", "a") ; a �±׸� ��Ƴ���
count_links := com_invoke(links, "length")   ; a �±׷� ���� ����

Loop, %count_links%
{
  if A_index = 6
    break
  A_link  := com_invoke(links, A_index) ; ���� a �±׷� �� �� �׸��ϳ��ϳ� ��´�.
  url     := com_invoke(A_link, "href") ; ��ũ�׸� �ɸ� url �� ��´�.
  msgbox, %url%
}

com_invoke(doc, "writeln", "<h1>�̰� �̿ܿ��� ���� �޼ҵ尡 �ֽ��ϴ�.</h1><br>")
sleep, 2000
com_invoke(doc, "writeln", "�������� �����е��� �����ؼ� ������ �˷��ּ�~<br>")
sleep, 3000
com_invoke(doc, "writeln", "<h1><font color='#0000FF'><strong>�������� ���񿵹��̾����ϴ�. </strong></font></h1><br> ")
sleep, 3000
com_invoke(doc, "writeln", "<h1><font color='#0000FF'><strong>���� ���´� �����ϴ�. ��������~ </strong></font></h1><br> ")
sleep, 2000
com_invoke(doc, "writeln", "<h1><font color='#0000FF'><strong>��� ��ȸ���� �������� ������ �Ұ��ϴ� �������� �ϰڽ��ϴ�.</strong></font></h1><br><br> ")
sleep, 3000
com_invoke(doc, "writeln", "<h1><font color='#FF0000'><strong>�ڳ׵��� ���� �ִ� �ͽ��÷ξ�� ����� �ڵ������ϳ�~ </strong></font></h1> ")
sleep, 5000
com_invoke(ie, "quit")
com_release(ie) ; ��ü�� �����ϴ� ��üī��Ʈ�� �ϳ� �ٿ��ش�. ���� �ϳ��ۿ� ������ �Ҹ������ش�. ��ǻ� �ʿ����.