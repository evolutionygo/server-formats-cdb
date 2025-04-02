--サイバネティック・ヒドゥン・テクノロジー
--Cybernetic Hc92773018den Technology
function c92773018.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Destroy opponent's attacking monster
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc92773018(c92773018,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCondition(c92773018.condition)
	e2:SetCost(c92773018.cost)
	e2:SetTarget(c92773018.target2)
	e2:SetOperation(c92773018.activate)
	c:RegisterEffect(e2)
end
c92773018.listed_names={CARD_CYBER_DRAGON}
function c92773018.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==1-Duel.GetTurnPlayer()
end
function c92773018.cfilter(c)
	return c:IsFaceup() and (c:IsCode(CARD_CYBER_DRAGON) or (c:IsType(TYPE_FUSION) and c:ListsCodeAsMaterial(CARD_CYBER_DRAGON))) and c:IsAbleToGraveAsCost()
end
function c92773018.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92773018.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c92773018.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c92773018.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,1,0,0)
end
function c92773018.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:CanAttack() and not tc:IsStatus(STATUS_ATTACK_CANCELED) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end