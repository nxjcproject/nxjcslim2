using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlServerDataAdapter
{
    public interface ISqlServerDataFactory
    {
        /// <summary>
        /// 删除数据库数据数据
        /// </summary>
        /// <param name="delete"></param>
        /// <returns></returns>
        int Remove(Delete delete);
        /// <summary>
        /// 向数据库插入数据
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="insert"></param>
        /// <returns></returns>
        int Save<T>(Insert<T> insert);
        /// <summary>
        /// 更新数据库数据
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="update"></param>
        /// <returns></returns>
        int Save<T>(Update<T> update);
        /// <summary>
        /// 一般检索数据库数据,返回DataTable
        /// </summary>
        /// <param name="query"></param>
        /// <returns></returns>
        DataTable Query(Query query);
        /// <summary>
        /// 复杂检索数据库数据，返回DataTable
        /// </summary>
        /// <param name="complexQuery"></param>
        /// <returns></returns>
        DataTable Query(ComplexQuery complexQuery);
        /// <summary>
        /// 一般检索数据库数据，返回泛型集合
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="query"></param>
        /// <returns></returns>
        IEnumerable<T> Query<T>(Query query);
        /// <summary>
        /// 复杂检索数据库数据，返回泛型集合
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="complexQuery"></param>
        /// <returns></returns>
        IEnumerable<T> Query<T>(ComplexQuery complexQuery);
    }
}
