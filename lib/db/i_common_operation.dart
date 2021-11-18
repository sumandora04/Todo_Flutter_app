abstract class ICommonOperation{
  Future<int> deleteItem(String table,int id, String colName);
  Future<int> getItemCount(String table);

}