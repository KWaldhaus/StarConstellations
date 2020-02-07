using System.Collections.Generic;
using UnityEngine;

namespace DefaultNamespace
{
	public class InitialiseData : MonoBehaviour
	{
		public GameObject starPrefab;
		List<StarDataStruct> _starDataStructs = new List<StarDataStruct>();

		private void Start()
		{
			DataReader dataReader = new DataReader();
			_starDataStructs = dataReader.ReadFile();
			SpawnStars();
		}

		private void SpawnStars()
		{
			//foreach (var starDataStruct in _starDataStructs)
			for (int i = 0; i < _starDataStructs.Count / 100; i++)
			{
				Instantiate(starPrefab, _starDataStructs[i].Position, Quaternion.identity);
			}
		}
	}
}