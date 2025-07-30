using System;
using System.Collections.Generic;
using System.Linq;



namespace RealEquationSolver;


/// <summary>
/// Equation solver for finding real roots of equations up to 4th degree.
/// </summary>
public static class RealEquationSolver {


	const double Epsilon = 1e-5;

	#region Solve
	/// <summary>
	/// Solves equation of the form: a * x + b = 0
	/// </summary>
	/// <param name="a">Coefficient of x.</param>
	/// <param name="b">Constant term.</param>
	/// <returns>Real root of the equation, or NaN if no solution.</returns>
	public static double SolveLinear(double a, double b) {
		if (IsZeroApprox(a)) return double.NaN;
		return -b / a;
	}

	public static float SolveLinear(float a, float b) {
		return (float)SolveLinear((double)a, (double)b);
	}

	/// <summary>
	/// Solves equation of the form: a * x^2 + b * x + c = 0
	/// </summary>
	/// <param name="a">Coefficient of x^2.</param>
	/// <param name="b">Coefficient of x.</param>
	/// <param name="c">Constant term.</param>
	/// <returns>Sorted array of real roots.</returns>
	public static double[] SolveQuadratic(double a, double b, double c) {
		if (IsZeroApprox(a)) {
			double x = SolveLinear(b, c);
			if (double.IsNaN(x)) return [];
			return [x];
		}

		double p = b / a;
		double q = c / a;
		double D = p * p - 4 * q;

		if (D < 0) return [];

		if (IsZeroApprox(D)) return [-p / 2];

		double negHalfP = -p / 2;
		double halfSqrtD = Math.Sqrt(D) / 2;
		double[] xValues = [negHalfP + halfSqrtD, negHalfP - halfSqrtD];
		Array.Sort(xValues);
		return xValues;
	}

	public static float[] SolveQuadratic(float a, float b, float c) {
		return SolveQuadratic((double)a, (double)b, (double)c).Select(x => (float)x).ToArray();
	}

	/// <summary>
	/// Solves equation of the form: a * x^3 + b * x^2 + c * x + d = 0
	/// </summary>
	/// <param name="a">Coefficient of x^3.</param>
	/// <param name="b">Coefficient of x^2.</param>
	/// <param name="c">Coefficient of x.</param>
	/// <param name="d">Constant term.</param>
	/// <returns>Sorted array of real roots.</returns>
	/// <remarks>For large argument values, answers may be inaccurate or incorrect.</remarks>
	public static double[] SolveCubic(double a, double b, double c, double d) {
		if (IsZeroApprox(a)) return SolveQuadratic(b, c, d);

		double p = b / a;
		double q = c / a;
		double r = d / a;

		double pDiv3 = p / 3;
		double pDiv3Pow2 = pDiv3 * pDiv3;
		double pDiv3Pow3 = pDiv3Pow2 * pDiv3;

		double Q = pDiv3Pow2 - q / 3;
		double R = pDiv3Pow3 + (r - pDiv3 * q) / 2;

		double QPow3 = Q * Q * Q;
		double RPow2 = R * R;

		List<double> xValues = [];

		if (IsEqualApprox(QPow3, RPow2)) {
			if (IsZeroApprox(R)) {
				xValues.Add(-pDiv3);
			}
			else {
				double cbrtR = Math.Cbrt(R);
				xValues.Add(-2 * cbrtR - pDiv3);
				xValues.Add(cbrtR - pDiv3);
			}
		}
		else if (QPow3 > RPow2) {
			double f = Math.Acos(R / Math.Sqrt(QPow3)) / 3;
			double neg_double_sqrt_Q = -2 * Math.Sqrt(Q);
			double TAU_div_3 = Math.Tau / 3;
			xValues.Add(neg_double_sqrt_Q * Math.Cos(f) - pDiv3);
			xValues.Add(neg_double_sqrt_Q * Math.Cos(f + TAU_div_3) - pDiv3);
			xValues.Add(neg_double_sqrt_Q * Math.Cos(f - TAU_div_3) - pDiv3);
		}
		else {
			if (IsZeroApprox(Q)) {
				xValues.Add(-Math.Cbrt(r - pDiv3Pow3) - pDiv3);
			}
			else if (Q > 0) {
				double f = Math.Acosh(Math.Abs(R) / Math.Sqrt(QPow3)) / 3;
				xValues.Add(-2 * Math.Sign(R) * Math.Sqrt(Q) * Math.Cosh(f) - pDiv3);
			}
			else {
				double f = Math.Asinh(Math.Abs(R) / Math.Sqrt(Math.Abs(QPow3))) / 3;
				xValues.Add(-2 * Math.Sign(R) * Math.Sqrt(Math.Abs(Q)) * Math.Sinh(f) - pDiv3);
			}
		}
		var result = xValues.Where(x => !IsNan(x) && !double.IsInfinity(x)).ToArray();
		Array.Sort(result);
		return result;
	}

	/// <summary>
	/// Returns a sorted array of real roots of an equation of the form: a * x^4 + b * x^3 + c * x^2 + d * x + e = 0
	/// </summary>
	/// <param name="a">Coefficient of x^4.</param>
	/// <param name="b">Coefficient of x^3.</param>
	/// <param name="c">Coefficient of x^2.</param>
	/// <param name="d">Coefficient of x.</param>
	/// <param name="e">Constant term.</param>
	/// <returns>Sorted array of real roots.</returns>
	/// <remarks>For large argument values, answers may be inaccurate or incorrect.</remarks>
	public static double[] SolveQuartic(double a, double b, double c, double d, double e) {
		if (IsZeroApprox(a)) return SolveCubic(b, c, d, e);
		double a1 = b / a;
		double b1 = c / a;
		double c1 = d / a;
		double d1 = e / a;
		double half_a1 = a1 / 2;
		double half_a1_pow_2 = half_a1 * half_a1;
		double half_a1_pow_3 = half_a1_pow_2 * half_a1;
		// Converting to a depressed quartic. x = u - a1 / 4 -> u^4 + p * u^2 + q * u + r = 0
		double p = (-3.0 / 2.0) * half_a1_pow_2 + b1;
		double q = half_a1_pow_3 - half_a1 * b1 + c1;
		double r = (-3.0 / 16.0) * (half_a1_pow_2 * half_a1_pow_2) + half_a1_pow_2 * b1 / 4 - half_a1 * c1 / 2 + d1;
		var u_values = new List<double>();
		if (IsZeroApprox(q)) {
			foreach (var u_pow_2 in SolveQuadratic(1, p, r)) {
				if (IsZeroApprox(u_pow_2)) {
					u_values.Add(0);
				}
				else if (u_pow_2 > 0) {
					double u = Math.Sqrt(u_pow_2);
					u_values.Add(u);
					u_values.Add(-u);
				}
			}
		}
		else {
			double p_pow_2 = p * p;
			double p_pow_3 = p_pow_2 * p;
			double half_q = q / 2;
			double cubic_b = 2.5 * p;
			double cubic_c = 2 * p_pow_2 - r;
			double cubic_d = (p_pow_3 - p * r - half_q * half_q) / 2;
			double y = SolveCubic(1, cubic_b, cubic_c, cubic_d).Max();
			double p_add_y = p + y;
			double sqrt_p_add_2y = Math.Sqrt(p_add_y + y);
			double half_q_div_sqrt_p_add_2y = half_q / sqrt_p_add_2y;
			var new_u_values = SolveQuadratic(1, -sqrt_p_add_2y, p_add_y + half_q_div_sqrt_p_add_2y)
				.Concat(SolveQuadratic(1, sqrt_p_add_2y, p_add_y - half_q_div_sqrt_p_add_2y));
			foreach (var new_u in new_u_values) {
				if (!u_values.Any(u => IsZeroApprox(new_u - u)))
					u_values.Add(new_u);
			}
		}
		// Converting back from depressed quartic. x = u - a1 / 4
		double a1_div_4 = a1 / 4;
		var x_values = u_values.Select(u => u - a1_div_4).ToArray();
		Array.Sort(x_values);
		return x_values;
	}
	#endregion

	#region Generate
	/// <summary>
	/// Returns the coefficients of a equation with the given root, in the form: a * x + b = 0, where the leading coefficient a is always 1.
	/// </summary>
	/// <param name="r1">Root of the equation.</param>
	/// <returns>Array of coefficients [1, b].</returns>
	public static double[] GenerateLinear(double r1) {
		return new[] { 1.0, -r1 };
	}

	/// <summary>
	/// Returns the coefficients of a equation with the given roots, in the form: a * x^2 + b * x + c = 0, where the leading coefficient a is always 1.
	/// </summary>
	/// <param name="r1">First root.</param>
	/// <param name="r2">Second root.</param>
	/// <returns>Array of coefficients [1, b, c].</returns>
	public static double[] GenerateQuadratic(double r1, double r2) {
		double b = -(r1 + r2);
		double c = r1 * r2;
		return new[] { 1.0, b, c };
	}

	/// <summary>
	/// Returns the coefficients of a equation with the given roots, in the form: a * x^3 + b * x^2 + c * x + d = 0, where the leading coefficient a is always 1.
	/// </summary>
	/// <param name="r1">First root.</param>
	/// <param name="r2">Second root.</param>
	/// <param name="r3">Third root.</param>
	/// <returns>Array of coefficients [1, b, c, d].</returns>
	public static double[] GenerateCubic(double r1, double r2, double r3) {
		double b = -(r1 + r2 + r3);
		double c = (r1 * r2 + r1 * r3 + r2 * r3);
		double d = -(r1 * r2 * r3);
		return new[] { 1.0, b, c, d };
	}

	/// <summary>
	/// Returns the coefficients of a equation with the given roots, in the form: a * x^4 + b * x^3 + c * x^2 + d * x + e = 0, where the leading coefficient a is always 1.
	/// </summary>
	/// <param name="r1">First root.</param>
	/// <param name="r2">Second root.</param>
	/// <param name="r3">Third root.</param>
	/// <param name="r4">Fourth root.</param>
	/// <returns>Array of coefficients [1, b, c, d, e].</returns>
	public static double[] GenerateQuartic(double r1, double r2, double r3, double r4) {
		double b = -(r1 + r2 + r3 + r4);
		double c = (r1 * r2 + r1 * r3 + r1 * r4 + r2 * r3 + r2 * r4 + r3 * r4);
		double d = -(r1 * r2 * r3 + r1 * r2 * r4 + r1 * r3 * r4 + r2 * r3 * r4);
		double e = r1 * r2 * r3 * r4;
		return new[] { 1.0, b, c, d, e };
	}
	#endregion


	static bool IsEqualApprox(double x, double y) {
		return IsZeroApprox(x - y);
	}

	static bool IsZeroApprox(double x) {
		return Math.Abs(x) < Epsilon;
	}
}
