#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <cstdio>
#include <string>
#include <cstring>
#include <iomanip>
#include <algorithm>
#include <vector>
#include <cmath>
#include <cstdlib>
#include <sstream>
#include <fstream>
#include <stdio.h>
#include <set>
#include <map>
#include <utility>
#include <numeric>
#include <queue>
#include <bitset>
#include <stack>
#include <unordered_map>

using namespace std;

#define all(v) (v).begin(),(v).end()
#define SRT(v) sort(all(v))
#define rall(v) (v).rbegin(),(v).rend()
#define rSRT(v) sort(rall(v))
#define sz(a) int((a).size())
#define sc(x) scanf("%d", &x)
#define scl(x) scanf("%lld", &x)
#define PB push_back
#define mem(a, b) memset(a, b, sizeof(a))
#define MP make_pair
#define EPS 1e-9
#define Mod (ll)1000000007
#define oo (int)1<<30
#define OO (ll)1ll<<60
#define PI 3.141592653589793
#define F first
#define S second
#define pw(x) (x)*1LL*(x)

typedef stringstream ss;
typedef long long ll;
typedef vector<int> vi;
typedef vector<string> vs;
typedef vector<long long> vll;
typedef vector<bool> vb;
typedef vector<double> vd;
typedef vector<vi> vvi;
typedef pair<int, int> ii;
typedef vector<ii>vii;
typedef pair<int, ll> il;
typedef vector<vector<ii> > vvii;
typedef vector<vector<il> > vvil;

//ll gcd(ll a, ll b) { return !b ? a : gcd(b, a % b); }
//ll lcm(ll a, ll b) { return (a / gcd(a, b)) * b; }
//int dcmp(long double x, long double y) { return fabs(x - y) <= EPS ? 0 : x < y ? -1 : 1; }

//string alpha = "abcdefghijklmnopqrstuvwxyz";
//string vowels = "aeoui";
//string pm = "AHIMOTUVWXY";

unordered_map<string, string>f[10];
vs grp[10];

void testMaps()
{
	for (int i = 1; i <= 9; i++) {
		for (auto it = f[i].begin(); it != f[i].end(); it++) {
			cout << it->F << "  " << it->S << endl;
		}
		cout << endl;
	}
}


string getMicroWord(vs &ops)
{
	string ret;

	for (int i = 1; i <= 9; i++) {
		int cnt = 0;
		for (int j = 0; j < sz(grp[i]); j++) {
			for (int k = 0; k < sz(ops); k++) {
				if (grp[i][j] == ops[k]) {
					ret += f[i][ops[k]];
					cnt = 1;
					break;
				}
			}
			if (cnt) break;
		}
		if (!cnt) ret += f[i]["noaction"];
	}
	return ret;
}

void fixString(string& str)
{
	for (int i = 0; i < sz(str); i++) {
		if (isalpha(str[i])) str[i] = tolower(str[i]);
	}
}

int main()
{
	//freopen("simple.in", "r", stdin);
	//freopen("output.txt", "w", stdout);
	for (int i = 1; i <= 9; i++) {
		ifstream input; input.open("f" + to_string(i) + ".txt");
		int n; input >> n;
		while (n--) {
			string op, code; input >> op >> code;
			fixString(op);
			f[i][op] = code;
			if (op != "noaction") grp[i].PB(op);
		}
		input.close();
	}
	for (int i = 6; i <= 6; i++) {
		ifstream input; input.open("mode" + to_string(i) + ".txt");
		ofstream out; out.open("modeO" + to_string(i) + ".txt");
		int n; input >> n;
		while (n--) {
			int m; input >> m; vs vec;
			while (m--) {
				string op; input >> op;
				fixString(op);
				vec.PB(op);
			}
			string microword = getMicroWord(vec);
			out << microword << endl;
			cout << microword << endl;
			cout << sz(microword) << endl;
		}
		cout << endl;
	}
	cout << "done" << endl;
	int wait; sc(wait);
}