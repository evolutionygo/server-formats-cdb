--ゲート・ブロッカー
function c100100090.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(c100100090)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c100100090.con)
	e1:SetTargetRange(0,1)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
function c100100090.con(e)
	return Duel.IsEnvironment(511600371,1-e:GetHandlerPlayer())
end