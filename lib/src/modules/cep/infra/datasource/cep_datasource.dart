import '../models/cep_model.dart';

abstract class CepDatasource {
  Future<CepModel> getCep(String cep);
  Future<void> saveAddress(String cep, String endereco);
}
