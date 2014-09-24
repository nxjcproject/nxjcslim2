using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SqlServerDataAdapter.Infrastruction
{
    public class JoinCriterion
    {
        private IDictionary<string, string> _joinFieldDictionary;

        public JoinCriterion()
        {
            _joinFieldDictionary = new Dictionary<string, string>();
        }
        /// <summary>
        /// 在默认连接字符串属性为空时负责存储连接字段
        /// </summary>
        public IDictionary<string, string> JoinFieldDictionary
        {
            get { return _joinFieldDictionary; }
            set { _joinFieldDictionary = value; }
        }
        /// <summary>
        /// 该属性不为空时，生成连接字符串将不查询连接字段字典属性
        /// </summary>
        public string DefaultJoinFieldName { get; set; }
        public JoinType JoinType { get; set; }
    }
}
