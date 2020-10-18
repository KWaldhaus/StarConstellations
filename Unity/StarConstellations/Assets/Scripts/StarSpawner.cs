using System.Collections.Generic;
using Unity.Entities;
using UnityEngine;

namespace DefaultNamespace
{
    public class StarSpawner : MonoBehaviour
    {
        public GameObject starPrefab;
        public int starAmount;

        private EntityManager entityManager;
        private List<StarDataStruct> _starDataStructs = new List<StarDataStruct>();

        public void Start()
        {
            DataReader dataReader = new DataReader();
            _starDataStructs = dataReader.ReadFile();
            SpawnStars();
            World world = World.DefaultGameObjectInjectionWorld;
            EntityManager entityManager = world.EntityManager;
        }

        private void SpawnStars()
        {
            //foreach (var starDataStruct in _starDataStructs)
            for (int i = 0; i < _starDataStructs.Count / 100; i++)
            {
                var star = entityManager.Instantiate(starPrefab);
            }
        }
    }
}