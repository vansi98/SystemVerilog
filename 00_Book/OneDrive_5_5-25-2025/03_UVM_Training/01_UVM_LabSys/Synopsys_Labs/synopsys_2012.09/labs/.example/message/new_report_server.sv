class new_report_server extends uvm_report_server;
  `uvm_object_utils(new_report_server)

  function new(string name = "new_report_server");
    super.new();
  endfunction

  virtual function string compose_message(uvm_severity severity, string name, id, message, filename, int line);
    return super.compose_message(severity, "", id, message, filename, line);
  endfunction 
 
endclass : new_report_server

