--白兵戦型お手伝いロボ
--Helping Robo for Combat (GOAT)
--Activation timing
function c504700076.initial_effect(c)
	--Draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc504700076(c504700076,0))
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c504700076.condition)
	e1:SetTarget(c504700076.drtg)
	e1:SetOperation(c504700076.drop)
	c:RegisterEffect(e1)
end
function c504700076.condition(e,tp,eg,ep,ev,re,r,rp)
	local other=e:GetHandler():GetBattleTarget()
	return other and other:IsControler(1-tp) and other:IsBattleDestroyed()
end
function c504700076.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c504700076.drop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Draw(tp,1,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_HAND,0,1,1,nil)
		Duel.SendtoDeck(g,nil,1,REASON_EFFECT)
	end
end