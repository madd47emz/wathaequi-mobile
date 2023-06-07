import 'package:wathaequi/models/Paper.dart';
import 'package:wathaequi/repositories/doc_repo.dart';

class DocViewModel{
 DocRepo _docRepo = DocRepo();
 Stream<List<Paper>>? getPapers() {

  return _docRepo.getPapers();
 }
 Future<String> getNaissancePdf(){
  return _docRepo.downloadNaissance();

 }
}