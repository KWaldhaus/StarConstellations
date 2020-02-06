using System.Collections.Generic;
using DefaultNamespace;

public class StarData
{
    private List<StarDataStruct> _starDataStructs = new List<StarDataStruct>();
    public void GetStars()
    {
        DataReader dataReader = new DataReader();
        _starDataStructs = dataReader.ReadFile();
    }
}
