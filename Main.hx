/*###################################
Trabalho LP - PUC Minas
Componentes:
    Bruno Castanheira Eliazar  M:692589
    Gabriel Guimaraes Fernandes  M:713129
    Mateus Henrique Ramalho Lima  M:704800
29/08/2021
###################################*/


///Classe Message:
///Armazena o conteudo de uma mensagem e 
///a data em que ela foi enviada.
class Message
{

    public function new(msg:String)
    {
        str = msg;
        date = Date.now();
    }

    //metodos:

    ///toString() -
    ///retorna: o corpo da mensagem seguido pela data de envio
    public function toString():String
    {
        return (str + " - " + DateTools.format(date, "%d-%m-%Y_%H:%M:%S") + "\n");
    }

    //dados:
    private var str:String;
    private var date:Date;
}



class MessageSystem
{
    public static final instance:MessageSystem = new MessageSystem();

    ///Construtor
    ///Como o construtor e' privado, o membro instance atua como
    ///a unica instancia dessa classe(um singleton). 
    private function new()
    {
        messages = [];
    };

    //metodos:

    ///printMessages() -
    ///mostra todas as mensagens e as datas em
    ///que foram enviadas
    public function printMessages()
    {
        var i = 0;
        Sys.println("Foram encontradas " + Std.string(messages.length) + " mesagens: ");
        while(i < messages.length)
        {
            Sys.print("->" + messages[i].toString());
            ++i;
        }
        Sys.println("");
    }

    ///sendMessage
    ///armazena uma mensagem na lista depois de esperar algum tempo
    public function sendMessage(str:String)
    {
        sys.thread.Thread.create(() -> {
            Sys.sleep(Std.random(15)); //esperar alguns segundos para enviar
            messages.push(new Message(str));
        });
    }

    //dados:
    private var messages:Array<Message>;

}


class Main 
{
    static public function main():Void
    {
        var option:Int = 0;
        var msg:String = "";
        var status:Bool = true;

        
        while(status)
        {   
            trace("Oque voce deseja fazer: 
                    1 - Enviar uma mensagem
                    2 - Mostrar as mensagens
                    3 - Sair\n" );

            //ler um inteiro do teclado
            option = Std.parseInt(Sys.stdin().readLine());

            switch (option)
            {
                case 1:
                    Sys.print("Digite a mensagem: ");
                    msg = Sys.stdin().readLine();
                    MessageSystem.instance.sendMessage(msg);
                case 2:
                    MessageSystem.instance.printMessages();
                case 3:
                    status = false;
                default:
                    Sys.println("Escolha uma opcao valida");
            }

        }
    }

  
}