--手をつなぐ魔人 (Anime)
--Hand-Holding Genie (Anime)
function c513000087.initial_effect(c)
	c:SetUniqueOnField(1,0,c:Alias())
	--atk limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c513000087.atlimit)
	c:RegisterEffect(e1)
	--defup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetCondition(c513000087.defcon)
	e2:SetValue(c513000087.defval)
	c:RegisterEffect(e2)
end
c513000087.listed_names={94535485}
function c513000087.atlimit(e,c)
	return c~=e:GetHandler()
end
function c513000087.defcon(e)
	return e:GetHandler():IsDefensePos()
end
function c513000087.defval(e,c)
	return Duel.GetMatchingGroup(Card.IsFaceup,c:GetControler(),LOCATION_MZONE,0,c):GetSum(Card.GetDefense)
end