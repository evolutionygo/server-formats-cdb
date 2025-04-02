--魔轟神ディアネイラ
--Fabled Dianaira
function c53199020.initial_effect(c)
	--Can be Tribute Summoned by Tributing 1 "Fabled" monster
	local e1=aux.AddNormalSummonProcedure(c,true,true,1,1,SUMMON_TYPE_TRIBUTE,aux.Stringc53199020(c53199020,0),c53199020.otfilter)
	--The effect of a Normal Spell activated by the opponent becomes "Your opponent discards 1 card"
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_SOLVING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c53199020.changecon)
	e1:SetOperation(c53199020.changeop)
	c:RegisterEffect(e1)
end
c53199020.listed_series={SET_FABLED}
function c53199020.otfilter(c,tp)
	return c:IsSetCard(SET_FABLED) and (c:IsControler(tp) or c:IsFaceup())
end
function c53199020.changecon(e,tp,eg,ep,ev,re,r,rp)
	return ep==1-tp and re:GetHandler():IsNormalSpell() and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c53199020.changeop(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	Duel.ChangeTargetCard(ev,g)
	Duel.ChangeChainOperation(ev,c53199020.rep_op)
end
function c53199020.rep_op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,1-tp,c53199020)
	Duel.DiscardHand(1-tp,nil,1,1,REASON_EFFECT|REASON_DISCARD)
end