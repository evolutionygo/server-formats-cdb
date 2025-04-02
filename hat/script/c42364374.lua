--アーマード・フライ
function c42364374.initial_effect(c)
	--atk def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetValue(1000)
	e1:SetCondition(c42364374.con)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_DEFENSE)
	c:RegisterEffect(e2)
end
function c42364374.con(e)
	local c=e:GetHandler()
	return not Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsRace,RACE_INSECT),c:GetControler(),LOCATION_MZONE,0,1,c)
end