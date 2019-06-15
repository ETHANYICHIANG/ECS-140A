package triangle

import "testing"

func TestGetTriangleType(t *testing.T) {
	tests := []struct {
		a, b, c  int
		expected triangleType
	}{
		{1001, 5, 6, UnknownTriangle},
		// TODO add more tests for 100% test coverage
		{1, 2005, 6, UnknownTriangle},
		{1, 5, 3006, UnknownTriangle},
		{-1, 5, 6, UnknownTriangle},
		{1, -5, 6, UnknownTriangle},
		{1, 5, -6, UnknownTriangle},
		{3, 4, 5, RightTriangle},
		{3, 4, 6, AcuteTriangle},
		{3, 6, 5, ObtuseTriangle},
		{3, 2, 5, InvalidTriangle},
	}

	for _, test := range tests {
		actual := getTriangleType(test.a, test.b, test.c)
		if actual != test.expected {
			t.Errorf("getTriangleType(%d, %d, %d)=%v; want %v", test.a, test.b, test.c, actual, test.expected)
		}
	}
}
