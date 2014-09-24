using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SqlServerDataAdapter.Infrastruction;
using System.Data.SqlClient;
using System.Data;
using SqlServerDataAdapter.Translators;
using AutoMapper;
using System.Collections;

namespace SqlServerDataAdapter
{
    public class SqlServerDataFactory : ISqlServerDataFactory
    {
        private string _connectionString;

        public SqlServerDataFactory(string connectionString)
        {
            _connectionString = connectionString;
        }

        /// <summary>
        /// 数据库连接字符串
        /// </summary>
        public string ConnectionString
        {
            get { return _connectionString; }
            set { _connectionString = value; }
        }

        /// <summary>
        /// 删除一行数据
        /// </summary>
        /// <param name="delete"></param>
        /// <returns></returns>
        public int Remove(Delete delete)
        {
            int result = 0;
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = conn.CreateCommand();
                DeleteTranslator.TranslateIntoDelete(delete, cmd);

                try
                {
                    conn.Open();
                    result = cmd.ExecuteNonQuery();
                }
                catch(Exception ex)
                {
                    throw new Exception(ex.Source + ":" + ex.Message);
                }
            }
            return result;
        }

        /// <summary>
        /// 插入一行数据
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="insert"></param>
        /// <returns></returns>
        public int Save<T>(Insert<T> insert)
        {
            int result = 0;
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = conn.CreateCommand();
                SaveTranslator.TranslateIntoInsert<T>(insert, cmd);

                try
                {
                    conn.Open();
                    result = cmd.ExecuteNonQuery();
                }
                catch(Exception ex)
                {
                    throw new Exception(ex.Source + ":" + ex.Message);
                }
            }
            return result;
        }

        /// <summary>
        /// 更新一行数据
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="update"></param>
        /// <returns></returns>
        public int Save<T>(Update<T> update)
        {
            int result = 0;
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = conn.CreateCommand();
                SaveTranslator.TranslateIntoUpdate<T>(update, cmd);

                try
                {
                    conn.Open();
                    result = cmd.ExecuteNonQuery();
                }
                catch(Exception ex)
                {
                    throw new Exception(ex.Source + ":" + ex.Message);
                }
            }
            return result;
        }

        /// <summary>
        /// 查询一张表中所有字段的数据
        /// </summary>
        /// <param name="query"></param>
        /// <returns></returns>
        public DataTable Query(Query query)
        {
            DataTable result = new DataTable();
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = conn.CreateCommand();
                QueryTranslator.TranslateIntoSelect(query, cmd);

                try
                {
                    //conn.Open();
                    SqlDataAdapter ad = new SqlDataAdapter(cmd);
                    ad.Fill(result);
                }
                catch(Exception ex)
                {
                    throw new Exception(ex.Source + ":" + ex.Message);
                }
            }
            return result;
        }

        /// <summary>
        /// 查询一张表中指定字段的数据
        /// </summary>
        /// <param name="complexQuery"></param>
        /// <returns></returns>
        public DataTable Query(ComplexQuery complexQuery)
        {
            DataTable result = new DataTable();
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = conn.CreateCommand();
                ComplexQueryTranslator.TranslateIntoComplexQuery(complexQuery, cmd);

                try
                {
                    //conn.Open();
                    SqlDataAdapter ad = new SqlDataAdapter(cmd);
                    ad.Fill(result);
                }
                catch(Exception ex)
                {
                    throw new Exception(ex.Source + ":" + ex.Message);
                }
            }
            return result;
        }

        /// <summary>
        /// 一般检索数据库数据，返回泛型集合
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="query"></param>
        /// <returns></returns>
        public IEnumerable<T> Query<T>(Query query)
        {
            IList<T> result = new List<T>();
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                
                SqlCommand cmd = conn.CreateCommand();
                QueryTranslator.TranslateIntoSelect(query, cmd);

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        result.Add(Mapper.DynamicMap<T>(reader));
                    }
                }
                catch(Exception ex)
                {
                    throw new Exception(ex.Source + ":" + ex.Message);
                }
            }
            return result;
        }
        /// <summary>
        /// 复杂检索数据库数据，返回泛型集合
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="complexQuery"></param>
        /// <returns></returns>
        public IEnumerable<T> Query<T>(ComplexQuery complexQuery)
        {
            IList<T> result = new List<T>();
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = conn.CreateCommand();
                ComplexQueryTranslator.TranslateIntoComplexQuery(complexQuery, cmd);

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        result.Add(Mapper.DynamicMap<T>(reader));
                    }
                }
                catch(Exception ex)
                {
                    throw new Exception(ex.Source + ":" + ex.Message);
                }
            }
            return result;
        }
        /// <summary>
        /// 根据连接字符串和参数集合查询数据
        /// </summary>
        /// <param name="queryString"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        public DataTable Query(string queryString, params SqlParameter[] parameters)
        {
            DataTable result = new DataTable();

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = queryString;
                foreach (var item in parameters)
                {
                    cmd.Parameters.Add(item);
                }

                try
                {
                    //conn.Open();
                    SqlDataAdapter ad = new SqlDataAdapter(cmd);
                    ad.Fill(result);
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Source + ":" + ex.Message);
                }
            }

            return result;
        }
        /// <summary>
        /// 执行SQL语句
        /// </summary>
        /// <param name="sqlString"></param>
        /// <returns></returns>
        public int ExecuteSQL(string sqlString)
        {
            int result = 0;

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = sqlString;
                cmd.CommandType = CommandType.Text;

                try
                {
                    result = cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Source + ":" + ex.Message);
                }
            }

            return result;
        }
        /// <summary>
        /// 执行存储过程
        /// </summary>
        /// <param name="sqlString"></param>
        /// <returns></returns>
        public int ExecuteSQL(string storedProcName, params SqlParameter[] parameters)
        {
            int result = 0;

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = storedProcName;
                cmd.CommandType = CommandType.StoredProcedure;
                foreach (var item in parameters)
                {
                    cmd.Parameters.Add(item);
                }

                try
                {
                    result = cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Source + ":" + ex.Message);
                }
            }

            return result;
        }
        /// <summary>
        /// 执行SQL语句或者存储过程
        /// </summary>
        /// <param name="sqlString"></param>
        /// <returns></returns>
        public int ExecuteSQL(string sqlString, bool isStoredProcedure, params SqlParameter[] parameters)
        {
            int result = 0;

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = sqlString;

                if (isStoredProcedure == true)
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                }
                else
                {
                    cmd.CommandType = CommandType.Text;
                }

                foreach (var item in parameters)
                {
                    cmd.Parameters.Add(item);
                }

                try
                {
                    result = cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Source + ":" + ex.Message);
                }
            }

            return result;
        }
    }
}
