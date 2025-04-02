--念導力
--Telepathic Power
function c23323812.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc23323812(c23323812,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c23323812.condition)
	e1:SetTarget(c23323812.target)
	e1:SetOperation(c23323812.activate)
	c:RegisterEffect(e1)
end
function c23323812.condition(e,tp,eg,ep,ev,re,r,rp,chk)
	local dc=eg:GetFirst()
	local bc=dc:GetBattleTarget()
	return dc:IsPreviousControler(tp) and dc:GetPreviousRaceOnField()&RACE_PSYCHIC>0
		and bc:IsRelateToBattle() and bc:IsControler(1-tp) and bc==Duel.GetAttacker()
end
function c23323812.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local dc=eg:GetFirst()
	local bc=Duel.GetAttacker()
	if chk==0 then return bc:IsCanBeEffectTarget(e) end
	local atk=bc:GetAttack()
	Duel.SetTargetCard(bc)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,atk)
end
function c23323812.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsControler(1-tp) and Duel.Destroy(tc,REASON_EFFECT)>0 then
		local atk=tc:GetPreviousAttackOnField()
		Duel.Recover(tp,atk,REASON_EFFECT)
	end
end