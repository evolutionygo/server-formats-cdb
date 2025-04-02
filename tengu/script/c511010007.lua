--Ｎｏ．７ ラッキー・ストライプ (Anime)
--Number 7: Lucky Straight (Anime)
Duel.LoadCardScript("c82308875.lua")
function c511010007.initial_effect(c)
	c:EnableReviveLimit()
	--Xyz Summon procedure: 3 Level 7 monsters
	aux.AddXyzProcedure(c,nil,7,3)
	--Cannot be destroyed by battle, except with a "Number" monster
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(aux.NOT(aux.TargetBoolFunction(Card.IsSetCard,SET_NUMBER)))
	c:RegisterEffect(e1)
	--Make this card's ATK become equal to its original ATK multiplied by a die roll result
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511010007(c511010007,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetCondition(c511010007.atkcon)
	e2:SetCost(aux.dxmcostgen(1,1,nil))
	e2:SetTarget(c511010007.atktg)
	e2:SetOperation(c511010007.atkop)
	c:RegisterEffect(e2,false,REGISTER_FLAG_DETACH_XMAT)
end
c511010007.aux.xyz_number=7
c511010007.roll_dice=true
c511010007.listed_series={SET_NUMBER}
function c511010007.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	return bc and bc:IsControler(1-tp) and not (Duel.IsPhase(PHASE_DAMAGE) and Duel.IsDamageCalculated())
end
function c511010007.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c511010007.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local die_result=Duel.TossDice(tp,1)
		--This card's ATK becomes equal to its original ATK multiplied by the result, until the end of the Battle Phase
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(c:GetBaseAttack()*die_result)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD_DISABLE|RESET_PHASE|PHASE_BATTLE)
		c:RegisterEffect(e1)
	end
end