import Predicates
import GRDB

public protocol GRDBQueryConvertible: Predicate where Root: Keyable {
    associatedtype Expression: SQLExpressible
    var grdbQuery: Expression { get }
}


//MARK: - Element Predicates
extension Equals: GRDBQueryConvertible where Root: Keyable, Value: SQLExpressible {
    public var grdbQuery: some SQLExpressible {
        return Column(key()) == self.value
    }
}

extension GreaterThan: GRDBQueryConvertible where Root: Keyable, Value: SQLExpressible {
    public var grdbQuery: some SQLExpressible {
        return Column(key()) > self.value
    }
}

extension LessThan: GRDBQueryConvertible where Root: Keyable, Value: SQLExpressible {
    public var grdbQuery: some SQLExpressible {
        return Column(key()) < self.value
    }
}

extension GreaterThanOrEqual: GRDBQueryConvertible where Root: Keyable, Value: SQLExpressible {
    public var grdbQuery: some SQLExpressible {
        return Column(key()) >= self.value
    }
}

extension LessThanOrEqual: GRDBQueryConvertible where Root: Keyable, Value: SQLExpressible {
    public var grdbQuery: some SQLExpressible {
        return Column(key()) <= self.value
    }
}

//MARK: - Bool Predicates
extension BoolPredicate: GRDBQueryConvertible where Root: Keyable {
    public var grdbQuery: some SQLExpressible {
        return self.value
    }
}

//TODO: - Collection Predicates

//MARK: - Operators
extension Not: GRDBQueryConvertible where Root: Keyable, Base: GRDBQueryConvertible {
    public var grdbQuery: some SQLExpressible {
        return !self.basePredicate.grdbQuery.sqlExpression
    }
}

extension And: GRDBQueryConvertible where LHS: GRDBQueryConvertible, RHS: GRDBQueryConvertible {
    public var grdbQuery: some SQLExpressible {
        return self.lhs.grdbQuery.sqlExpression && self.rhs.grdbQuery.sqlExpression
    }
}

extension Or: GRDBQueryConvertible where LHS: GRDBQueryConvertible, RHS: GRDBQueryConvertible {
    public var grdbQuery: some SQLExpressible {
        return self.lhs.grdbQuery.sqlExpression || self.rhs.grdbQuery.sqlExpression
    }
}

//MARK: - String Predicates
extension StringContains: GRDBQueryConvertible where Root: Keyable {
    public var grdbQuery: some SQLExpressible {
        let column = Column(key())
        if self.caseSensitive {
            return column.like("%\(self.value)%")
        } else {
            return column.uppercased.like(("%\(self.value.uppercased())%"))
        }
    }
}

extension HasPrefix: GRDBQueryConvertible where Root: Keyable {
    public var grdbQuery: some SQLExpressible {
        return Column(key()).like("\(self.value)%")
    }
}

extension HasSuffix: GRDBQueryConvertible where Root: Keyable {
    public var grdbQuery: some SQLExpressible {
        return Column(key()).like("%\(self.value)")
    }
}
