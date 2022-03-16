public class Utils {
    
    public static Boolean validaCNPJ(string cnpj){
        if(cnpj.length() != 14){
            return false;
        }
        else{
            return true;
        }
    }

    public static Boolean validaCPF(string cpf){
        if(cpf.length() != 11){
            return false;
        }
        else{
            return true;
        }
    }
}
